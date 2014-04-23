#Encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  

  
  class ActionController::Base
    private
  
    #ajax请求处理frame
    def ajax_frame
      result = {status: "ok", content: ""}
      begin
        result = yield(result) || result if block_given?
      rescue Exception => ex
        result[:status] = "error"
        logger.error "#{caller[0][/`.*'/][1..-2]} error log================================================"
        logger.error ex.message
        logger.error ex.backtrace
        result[:content] = (Rails.env.development? || Rails.env.test?) ? ex.message : "操作失败，请重试或联系我们"
      end
      return result
    end
  end
end