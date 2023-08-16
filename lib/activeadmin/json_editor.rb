#-*- encoding: utf-8; tab-width: 2 -*-
require 'activeadmin/json_editor/version'
require 'activeadmin/resource_dsl'

module ActiveAdmin
  module JsonEditor
    class Engine < ::Rails::Engine
      initializer "activeadmin.json_editor.precompile" do |app|
        app.config.assets.precompile += %w(img/jsoneditor-icons.png active_admin/json_editor.js active_admin/json_editor.css)
      end

      rake_tasks do
        task 'assets:precompile' do
          fingerprint = /\-[0-9a-f]{32}\./
          Dir['public/assets/img/jsoneditor-icons-*'].each do |file|
            next unless file =~ fingerprint
            nondigest = file.sub fingerprint, '.'
            FileUtils.cp file, nondigest, verbose: true
          end
        end
      end
    end
  end
end
