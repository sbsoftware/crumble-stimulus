require "../../spec_helper"
require "http/client/response"

module Crumble::Stimulus::StimulusAssetSpec
  private def self.dispatch_asset(path)
    request = Crumble::Server::TestRequest.new(resource: path)
    response_io = IO::Memory.new
    response = Crumble::Server::TestResponse.new(response_io)
    context = HTTP::Server::Context.new(request, response)

    Crumble::Server::RequestDispatcher.new.call(context)
    context.response.close

    response_io.rewind
    HTTP::Client::Response.from_io(response_io)
  end

  describe StimulusAsset do
    it "registers a versioned, fingerprinted asset" do
      StimulusAsset.uri_path.should match(%r{\A/assets/stimulus-3\.2\.2_[a-f0-9]{32}\.js\z})
    end

    it "serves the registered JavaScript asset with its license notice" do
      response = dispatch_asset(StimulusAsset.uri_path)

      response.status_code.should eq(200)
      response.headers["Content-Type"].should eq("application/javascript")
      response.headers["ETag"].should eq(StimulusAsset.etag)
      response.headers["Cache-Control"].should contain("immutable")
      response.body.should eq(StimulusAsset.contents)
      response.body.should start_with("/*!\nStimulus is licensed under the MIT License:")
      response.body.should contain("Copyright © 2021 Basecamp, LLC.")
      response.body.should contain("The Software is provided \"as is,\"")
    end
  end
end
