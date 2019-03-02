class UploadsController < ApplicationController

     def uploads
     end
     
     def detail_import_csv
          FeeDetail.import(params[:file])
          redirect_to root_path
     end

     def master_import_csv
          Fee.import(params[:file])
          redirect_to root_path
     end

end