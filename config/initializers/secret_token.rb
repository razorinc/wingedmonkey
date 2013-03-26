# Copyright 2012-2013 Red Hat, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations
# under the License.

# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.


# Session key should not be in version control
# http://brakemanscanner.org/docs/warning_types/session_setting/

begin
  token = File.read('/etc/wingedmonkey/secret_token')
  raise RuntimeError, 'Secret token size is too small' if token.length < 30
  WingedMonkey::Application.config.secret_token = token.chomp
rescue Exception => e
  # If anything goes wrong we make sure that the token is random.
  # This is safe even when WingedMonkey is not configured correctly.
  # But session will be lost after each restart.
  Rails.logger.warn "Using randomly generated secret token: #{e.message}"
  token = SecureRandom.hex(80)
  File.open('/etc/wingedmonkey/secret_token','w'){|f| f.write(token)}
  WingedMonkey::Application.config.secret_token = token
end
