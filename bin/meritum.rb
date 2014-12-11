#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'
require 'time'

def extract_time(doc)
  m = doc.css(".curr-box-note").text.match(/(\d{1,2}\.\d{1,2}\.\d{4}).*?(\d{1,2}:\d{1,2})/)
  Time.parse(m[1] + " " + m[2])
end

def extract_rates(doc)
  def parse_number(x)
    "%.4f" % x.gsub(",", ".").to_f
  end

  ary = doc.css("#currency_table td").map(&:text).each_slice(3).map { |currency, a, b|
    [currency, [parse_number(a), parse_number(b)]]
  }
  Hash[ary]
end

def get_doc(uri)
  html = open(uri).read
  Nokogiri::HTML(html)
end

uri = "http://meritumbank.pl/finanse_osobiste/e-kantor/e-kantor.html"
doc = get_doc(uri)
time = extract_time(doc)
rates = extract_rates(doc)

STDERR.puts "[lOG] #{Time.now} #{time.to_i} #{rates.inspect}"
system "mkdir -p ~/.meritum"
File.open("/Users/wojtek/.meritum/#{time.to_i}", "w") do |f|
  f.puts rates.map { |currency, (a, b)| [currency, a, b].join(" ") }
end
