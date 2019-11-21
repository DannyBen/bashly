; --------------------------------------------------
; This script generates the demo svg
; --------------------------------------------------
#SingleInstance Force
SetkeyDelay 0, 50

; NOTE: This should be executed in the demo folder

Outfile := "cast.svg"
Template := "window_frame"

Return

Type(Command, Delay=2000) {
  Send % Command
  Sleep 500
  Send {Enter}
  Sleep Delay
}

F12::
  Type("rm -rf myapp")
  ; Type("termtosvg " Outfile " -t " Template)
  Type("rm cast.json {;} asciinema rec cast.json")

  Type("mkdir myapp && cd ./myapp")
  Type("bashly")

  Type("{#} Create a sample Bashly configuration file", 500)
  Type("bashly init")
  Type("vi src/bashly.yml", 4000)
  Type(":q!", 500)

  Type("{#} Generate the bash script", 500)
  Type("bashly generate")
  
  Type("{#} Run the bash script", 500)
  Type("./cli")
  Type("./cli --help")
  Type("./cli download -h")
  Type("./cli download")
  Type("./cli download somefile")
  Type("./cli download somefile --force")

  ; Type("{#} Replace the download function with your code", 500)
  ; Type("cat src/cli_download_command.sh")
  ; Type("echo 'echo downloading ${{}args[source]{}}' > src/cli_download_command.sh")

  ; Type("{#} Regenerate to merge the updated function", 500)
  ; Type("bashly generate")

  ; Type("{#} Run the bash script again", 500)
  ; Type("./cli download the-internet")

  Type("exit")
  Type("cat cast.json | svg-term --out cast.svg --window")
Return

^F12::
  Reload
return

^x::
  ExitApp
return
