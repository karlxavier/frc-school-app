class FeeDetailsController < ApplicationController

     def new
          @fee_detail = FeeDetail.new
          respond_to do |format|
               format.js
          end
     end

end