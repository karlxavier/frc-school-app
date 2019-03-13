class UploadsController < ApplicationController

     def uploads
     end

     def master_import_2016
          Fee.import_2016(params[:file])
          redirect_to root_path
     end

     def master_import_2019
          Fee.import_2019(params[:file])
          redirect_to root_path
     end

     def master_import_feb
          Fee.import_feb28(params[:file])
          redirect_to root_path
     end

     def opbal_2016
          Fee.import_opbal_2016(params[:file])
          redirect_to root_path
     end

     def import_mar_revenue2019
          Fee.import_mar_revenue2019(params[:file])
          redirect_to root_path
     end

end