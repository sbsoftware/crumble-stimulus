require "../spec_helper"

module Crumble::StimulusControllersSpec
  module Admin
    class AuditLogController < ::Stimulus::Controller
    end
  end

  class UserProfileController < ::Stimulus::Controller
  end

  describe ::Crumble::StimulusControllers do
    it "contains Stimulus.register calls for any defined Stimulus::Controller" do
      js = ::Crumble::StimulusControllers.to_js
      controllers = [Admin::AuditLogController, UserProfileController]

      controllers.each do |controller|
        expected_call = "Stimulus.register(#{controller.controller_name.to_js_ref}, #{controller.to_js_ref});"
        js.should contain(expected_call)
      end
    end
  end
end
