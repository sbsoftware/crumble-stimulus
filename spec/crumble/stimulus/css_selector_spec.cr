require "../../spec_helper"

module Crumble::Stimulus::CssSelectorSpec
  module Admin
    class AuditLogController < ::Stimulus::Controller
    end

    class UserProfileController < ::Stimulus::Controller
      values css_class: String
      targets :line_item
      outlets AuditLogController

      action :do_it do
      end
    end
  end

  describe "Stimulus CSS selectors" do
    it "builds a selector for controllers" do
      selector = Admin::UserProfileController.to_css_selector
      controller_name = Admin::UserProfileController.controller_name
      selector.should be_a(CSS::AttrSelector)
      selector.to_s.should eq("[data-controller='#{controller_name}']")
    end

    it "builds a selector for targets" do
      target = Admin::UserProfileController.line_item_target
      selector = target.to_css_selector
      selector.should be_a(CSS::AttrSelector)
      selector.to_s.should eq("[#{target.attr_name}='#{target.target_name}']")
    end

    it "builds a selector for values" do
      value = Admin::UserProfileController.css_class_value("active")
      selector = value.to_css_selector
      selector.should be_a(CSS::AttrSelector)
      selector.to_s.should eq("[#{value.attr_name}='#{value.value}']")
    end

    it "builds a selector for actions" do
      action = Admin::UserProfileController.do_it_action("click")
      selector = action.to_css_selector
      selector.should be_a(CSS::AttrSelector)
      selector.to_s.should eq("[data-action='#{action.attr_value}']")
    end

    it "builds a selector for outlets" do
      outlet = Admin::UserProfileController.audit_log_controller_outlet("#audit")
      selector = outlet.to_css_selector
      selector.should be_a(CSS::AttrSelector)
      selector.to_s.should eq("[#{outlet.attr_name}='#{outlet.selector}']")
    end

    it "builds a selector for params" do
      param = Admin::UserProfileController.param("status", "active")
      selector = param.to_css_selector
      selector.should be_a(CSS::AttrSelector)
      selector.to_s.should eq("[#{param.attr_name}='#{param.value}']")
    end
  end
end
