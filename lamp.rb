#!/bin/env ruby
# encoding: utf-8

# Imports

require 'date'

require_relative "inc/page.home.rb"
require_relative "inc/page.profile.rb"
require_relative "inc/page.sailboat.rb"
require_relative "inc/page.roadmap.rb"
require_relative "inc/page.cargo.rb"

require_relative "inc/object.layout.rb"
require_relative "inc/object.event.rb"
require_relative "inc/object.graph.rb"

class Hundred

	include Lamp

	def initialize query = nil

	end

	def application query = nil

<<<<<<< HEAD
		events = $jiin.command("grid hundred").to_h
		projects = []
		layout = Layout.new(query,events,projects)
=======
		events = $jiin.command("grid hundred")
		layout = Layout.new(query,events)
>>>>>>> origin/master

		puts "
		<!DOCTYPE html>
		<html>
		<head>
			<script src='https://ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js' ></script>
			<link rel='stylesheet' type='text/css' href='inc/style.main.css' />
			<script src='inc/script.main.js'></script>
			<title>Hundred Rabbits | #{$query}</title>
		</head>
		<body>
			#{layout.body}
		</body>
		</html>"

	end

end