require "js"
require "stimulus"

module Crumble
  class StimulusControllers < JS::Module
    js_import Application, Controller, from: Crumble::Stimulus.stimulus_url

    {% for ctrl_klass in ::Stimulus::Controller.all_subclasses %}
      js_class {{ctrl_klass}}
    {% end %}

    def_to_js do
      window.Stimulus = Application.start._call

      {% for ctrl_klass in ::Stimulus::Controller.all_subclasses %}
        Stimulus.register({{ctrl_klass}}.controller_name.to_js_ref, {{ctrl_klass}}.to_js_ref)
      {% end %}
    end

    @@asset_file = JavascriptFile.new("/assets/stimulus_controllers.js", self.to_js)

    def self.to_html_attrs(_tag, attrs)
      attrs["type"] = "module"
      attrs["src"] = @@asset_file.uri_path
    end
  end
end
