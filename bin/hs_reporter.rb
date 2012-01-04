#!/usr/bin/env ruby
#
# Copyright (c) 2012 Bartuer
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 2
# as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#

require File.join(File.dirname(__FILE__), 'hs_config')

class HSReporter 
  def initialize(transfer, encoder, config, log)
    @transfer = transfer
    @encoder = encoder
    @config = config
    @log = log
  end

  def report(target)
    encoded_url = @encoder.encoded_url
    addr = @config['report_mail']
    subject = "'stream done for #{target}'"
    download_url = encoded_url ? "'#{encoded_url}'" : "not available"
    view_url = @transfer.index_url
    @log.info("Reporter target : #{subject}")
    @log.info("Reporter encoded url : #{encoded_url}") if encoded_url
    @log.info("Reporter index url : #{view_url}")
    @log.info("Reporter address : #{addr}")
    if File.exist?("/usr/bin/osascript")
      `osascript #{File.join(File.dirname(__FILE__), 'msg.applescript')} #{addr} #{subject} #{download_url} #{view_url}`
    end
  end  
end

