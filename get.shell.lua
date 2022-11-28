if params.len != 2 or params[0] == "-h" or params[0] == "--help" then exit("<b>Usage: "+program_path.split("/")[-1]+" [ip_address] [port]</b>")
metaxploit = include_lib("/lib/metaxploit.so")
if not metaxploit then
    metaxploit = include_lib(current_path + "/metaxploit.so")
end if
if not metaxploit then exit("Error: Can't find metaxploit library in the /lib path or the current folder")
address = params[0]
port = params[1].to_int
net_session = metaxploit.net_use( address, port )
if not net_session then exit("Error: can't connect to net session")
metaLib = net_session.dump_lib

// 
// Exploit chain: Guest accounts last resort for each service type.
// 
result = metaLib.overflow("0x5D51D0FD", "magetelitext") // libHTTP 1.0.2
if not result then result = metaLib.overflow("0x121C868A", "codecodeintexttex") // libHTTP 1.0.1
if not result then result = metaLib.overflow("0x74E6A816", "toredp") // libHTTP 1.0.3
if not result then result = metaLib.overflow("0x314959AC", "aorb") // libHTTP 1.0.0 (guest)
if not result then result = metaLib.overflow("0x481D8767", "mask") // libSMTP 1.0.0
if not result then result = metaLib.overflow("0x14316037", "orsdistend_color_") // libFTP 1.0.0 (Guest)
if not result then result = metaLib.overflow("0x61D11589", "ewporttextslc") // libSSH 1.0.3
if not result then result = metaLib.overflow("0x56EB4E37", "intlinesizefirecttr") // libSSH 1.0.3
if not result then result = metaLib.overflow("0x56EB4E37", "_flushpara") // libSSH 1.0.3 (guest)
if not result then result = metaLib.overflow("0x31B2E17F", "timeanimpla") // libSSH 1.0.4 (guest)

if not result then exit("Program ended")
if typeof(result) == "shell" then
	result.start_terminal
else
	print("Error: expected shell, obtained: " + result)
end if
