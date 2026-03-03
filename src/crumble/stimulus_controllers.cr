require "js"
require "stimulus"
require "crumble"

module Crumble
  class StimulusControllers < JS::Module
    js_import Application, Controller, from: Crumble::Stimulus.stimulus_url

    CONTROLLER_CLASSES = [] of ::Stimulus::Controller.class

    macro add_controller(klass)
      class ::Crumble::StimulusControllers
        js_class {{klass}}

        {% CONTROLLER_CLASSES << klass %}
      end
    end

    macro finished
      @@asset_file = JavascriptFile.new("/assets/stimulus_controllers.js", self.to_js)

      def_to_js do
        window.Stimulus = Application.start._call

        {% for ctrl_klass in CONTROLLER_CLASSES %}
          Stimulus.register({{ctrl_klass}}.controller_name.to_js_ref, {{ctrl_klass}}.to_js_ref)
        {% end %}
      end
    end

    def self.to_html_attrs(_tag, attrs)
      attrs["type"] = "module"
      attrs["src"] = @@asset_file.uri_path
    end

    ToHtml.class_template do
      script self
    end

    def self.uri_path
      @@asset_file.uri_path
    end
  end
end
