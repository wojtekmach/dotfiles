#!/usr/bin/env ruby
require "logger"
require "nokogiri"

class PDM
  attr_reader :username, :logger, :phpsessid

  def initialize(username, logger: default_logger)
    @username = username
    @logger = logger

    sign_in
  end

  def sign_in
    logger.info("sign_in username:#{username}")
    text = request("/start.php", "name=#{username}&password=passwurd1&login=login&autologin=1")
    logger.debug(text)
    ids = text.split("\n").grep(/PHPSESSID/)
    @phpsessid = ids[1].match(/PHPSESSID=(.*?);/)[1]
    logger.debug("PHPSESSID: #{phpsessid}")
    player_info
  end

  def player_info
    text = request("/main")
    unless text =~ /Your info/
      raise text.inspect
    end

    html = Nokogiri::HTML(text)

    val = html.css(".statrow")[0].text.strip.split(/\s+/).last
    logger.info "weekly fights left:#{val}"

    val = html.css(".statrow")[1].text.strip.split(/\s+/).last
    logger.info "level:#{val}"
  end

  def reset_health
    logger.info("reset_health")
    text = request("/redirect.php?&page=shop&item=1")

    unless text =~ /And apparently they are free, well thats just great./
      raise text.inspect
    end
  end

  def set_health(percentage)
    logger.info("set_health #{percentage}")
    request("/redirect.php?percentage=#{percentage}&page=main")
  end

  def fight_by_name(name)
    id = begin
           Integer(name)
         rescue
           fetch_player_id(name)
         end
    logger.info("fight_by_name name:#{name.inspect} id:#{id}")

    fight(id)
  end

  def fight(id)
    x = 1
    y = 1
    html = request("/fight", "x=#{x}&y=#{y}&fodder=#{id}")

    if html =~ /Bot detection time/
      puts "Bot detection time"
      exit
    end

    html = Nokogiri::HTML(html)
    logger.debug(html.css(".sheader").text)
  end

  def player_id(name)
    name = name.gsub(/ /, "+")
    html = request("/redirect.php?nameSearch=#{name}&newlevel=&dispNo=60&page=fighters&Spirit=on&Alien=on&Magic=on&Bots=on&Boms=&swSpirit=1&swAlien=1&swMagic=1&swBots=1&swBoms=1")
    html = Nokogiri::HTML(html)
    html.css("input[name=fodder]").last["value"].to_i
  end

  def fetch_player_id(name)
    @ids ||= {}
    @ids[name] ||= player_id(name)
  end

  def default_logger
    logger = Logger.new(STDOUT)
    logger.level = ENV["DEBUG"] ? Logger::DEBUG : Logger::INFO
    logger.formatter = proc { |severity, datetime, progname, msg|
      "#{datetime} #{severity.ljust(5)} #{msg}\n"
    }
    logger
  end

  def request(path, data = nil)
    logger.debug("path: #{path}, data: #{data.inspect}")

    data = "--data '#{data}'" if data
    `curl -vvv --silent -L 'http://paranormaldeathmatch.co.uk#{path}' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: pl-PL,pl;q=0.8,en-US;q=0.6,en;q=0.4' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Referer: http://paranormaldeathmatch.co.uk/shop' -H 'Cookie: PHPSESSID=#{phpsessid}; _gat=1; _ga=GA1.3.1443375065.1450522547' -H 'Connection: keep-alive' #{data} --compressed 2>&1`.unpack("C*").pack("U*")
  end
end

if $0 == __FILE__
  username = ARGV[0].strip
  op1 = ARGV[1].to_s.strip
  op2 = ARGV[2].to_s.strip

  pdm = PDM.new(username)
  pdm.logger.info [username, op1, op2].inspect

  pdm.set_health(ENV["SET_HEALTH"]) if ENV["SET_HEALTH"]

  i = -1
  loop do
    i += 1
    if ENV["SLEEP"]
      seconds = Integer(ENV["SLEEP"])
      pdm.logger.info "sleep: #{seconds}s"
      sleep seconds
    end

    exit if ENV["N"] && Integer(ENV["N"]) == i
    pdm.reset_health if ENV["RESET_ONLY"]
    next if ENV["RESET_ONLY"]

    pdm.reset_health if (i % 5 == 0 && (ENV["RESET"] || ENV["RESET_ALWAYS"]))

    pdm.player_info if i % 25 == 0

    pdm.logger.info "iteration: #{i}"

    pdm.fight_by_name(op1)
    pdm.reset_health if ENV["RESET_ALWAYS"]
    pdm.fight_by_name(op2)
  end
end
