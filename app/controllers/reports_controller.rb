class ReportsController < ApplicationController

     def reports_collections
          if params[:filter].present?
               @collections = Receipt.filter_collections(DateTime.parse(params[:filter][:from_date].to_s).to_date, DateTime.parse(params[:filter][:to_date].to_s).to_date)
          else
               @collections = Receipt.filter_collections(Time.now, 2.days.ago).limit(100)
          end
     end

     def reports_revenues
          if params[:filter].present?
               @revenues = FeeDetail.filter_revenues(DateTime.parse(params[:filter][:from_date].to_s).to_date, DateTime.parse(params[:filter][:to_date].to_s).to_date)
          else
               @revenues = FeeDetail.filter_revenues(Time.now, 2.days.ago).limit(100)
          end
     end

end