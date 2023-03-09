#!/usr/bin/env bash

# Gregorian & Jalali ( Hijri_Shamsi , Solar ) Date Converter  Functions
# Author: JDF.SCR.IR =>> Download Full Version :  http://jdf.scr.ir/jdf
# License: GNU/LGPL _ Open Source & Free :: Version: 2.80 : [2020=1399]
# ---------------------------------------------------------------------
# 355746=361590-5844 & 361590=(30*33*365)+(30*8) & 5844=(16*365)+(16/4)
# 355666=355746-79-1 & 355668=355746-79+1 &  1595=605+990 &  605=621-16
# 990=30*33 & 12053=(365*33)+(32/4) & 36524=(365*100)+(100/4)-(100/100)
# 1461=(365*4)+(4/4)   &   146097=(365*400)+(400/4)-(400/100)+(400/400)

gregorian_to_jalali()
{
  local gregorian_year=$1
  local gregorian_month=$2
  local gregorian_day=$3

  local g_d_m=([1]=31 [2]=59 [3]=90 [4]=120 [5]=151 [6]=181 [7]=212 [8]=243 [9]=273 [10]=304 [11]=334)
  if [ "${gregorian_month}" -gt 2 ]
  then
    local gregorian_year2=$((gregorian_year + 1))
  else
    local gregorian_year2=$gregorian_year
  fi
  local days=$((355666 + (365 * gregorian_year) + ((gregorian_year2 + 3) / 4) - ((gregorian_year2 + 99) / 100) + ((gregorian_year2 + 399) / 400) + gregorian_day + g_d_m[gregorian_month-1]))
  local jalali_year=$((-1595 + (33 * (days / 12053))))
  local days=$((days % 12053))
  local jalali_year=$((jalali_year + (4 * (days / 1461))))
  local days=$((days % 1461))
  if [ $days -gt 365 ]
  then
    local jalali_year=$((jalali_year + ((days - 1) / 365)))
    local days=$(((days - 1) % 365))
  fi
  if [ $days -lt 186 ]
  then
    local jalali_month=$((1 + (days / 31)))
    local jalali_day=$((1 + (days % 31)))
  else
    local jalali_month=$((7 + ((days - 186) / 30)))
    local jalali_day=$((1 + ((days - 186) % 30)))
  fi

  JCC_RESULT=([1]="${jalali_year}" [2]="${jalali_month}" [3]="${jalali_day}")
  printf '%d %d %d' "${JCC_RESULT[@]}"
}

jalali_to_gregorian()
{
  local jalali_year=$(($1 + 1595))
  local jalali_month=$2
  local jalali_day=$3

  local days=$((-355668 + (365 * jalali_year) + ((jalali_year / 33) * 8) + (((jalali_year % 33) + 3) / 4) + jalali_day + ((jalali_month < 7) ? (jalali_month - 1) * 31 : ((jalali_month - 7) * 30) + 186)))
  local gregorian_year=$((400 * (days / 146097)))
  local days=$((days % 146097))
  if [ $days -gt 36524 ]
  then
    ((days--))
    local gregorian_year=$((gregorian_year + (100 * (days / 36524))))
    local days=$((days % 36524))
    if [ $days -ge 365 ]
    then
      ((days++))
    fi
  fi
  local gregorian_year=$((gregorian_year + (4 * (days / 1461))))
  local days=$((days % 1461))
  if [ $days -gt 365 ]
  then
    local gregorian_year=$((gregorian_year + ((days - 1) / 365)))
    local days=$(((days - 1) % 365))
  fi
  local gregorian_day=$((days + 1))
  if [[ ( ($((gregorian_year % 4)) = 0) && ($((gregorian_year % 100)) != 0) ) || ( $((gregorian_year % 400)) = 0 ) ]]
  then
    local kab_m2=29
  else
    local kab_m2=28
  fi
  local sal_a=([1]=31 [2]="${kab_m2}" [3]=31 [4]=30 [5]=31 [6]=30 [7]=31 [8]=31 [9]=30 [10]=31 [11]=30 [12]=31)
  local gregorian_month=1
  while [[ ($gregorian_month -lt 13) && ($gregorian_day -gt $((sal_a[gregorian_month]))) ]]
  do
    local gregorian_day=$((gregorian_day - sal_a[gregorian_month]))
    ((gregorian_month++))
  done

  JCC_RESULT=([1]="${gregorian_year}" [2]="${gregorian_month}" [3]="${gregorian_day}")
  printf '%d %d %d' "${JCC_RESULT[@]}"
}
