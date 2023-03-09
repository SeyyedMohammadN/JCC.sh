# Jalali Calendar Converter Shell Plugin (**JCC.sh**)

### Definition
It has two function for converting date from Gregorian to Jalali and another to converting from Jalali to Gregorian  


### Installing
* ##### [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)  
  1. Clone the repository:  
      ```zsh
      git clone https://github.com/smn7231/jcc.sh.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/jalali-calendar-converter
      ```
  2. Add `jalali-calendar-converter` to your plugins array:
      ```zsh
      plugins=(... jalali-calendar-converter ...)
      ```
  3. Reload your shell:
      ```zsh
      exec zsh
      ```

* #### Manual
  Run this command for loading functions in your environment:

  ```bash
  source jalali-calendar-converter.sh
  ```  
  **Note**: You can also add this command to your **_shell profile_** or **_startup file_** for automatically loading plugin functions.

### Using:
* For converting Gregorian date to Jalali date:  
  ```bash
  gregorian_to_jalali <gregorianYear> <gregorianMonth> <gregorianDay>
  ```  
  1. First argument: Gregorian year (full 4 digits)  
  2. Second argument: Gregorian month (1-12)[^leadingZeroNote]  
  3. Third argument: Gregorian day (1-31)[^leadingZeroNote]  


* For converting Jalali date to Gregorian date:  
  ```bash
  jalali_to_gregorian <jalaliYear> <jalaliMonth> <jalaliDay>
  ```  
  1. First argument: Jalali year (full 4 digits)  
  2. Second argument: Jalali month (1-12)[^leadingZeroNote]  
  3. Third argument: Jalali day (1-31)[^leadingZeroNote]  

<br>

[^leadingZeroNote]: Remove the worthless zero before the input numbers; for example, convert 02 to 2 (whole number), then enter it into arguments.  
