require 'rspec'
require 'fakefs/spec_helpers'

APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
$: << File.join(APP_ROOT, 'lib/command_line_email')

