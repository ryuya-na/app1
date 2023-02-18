class DiariesController < ApplicationController

    before_action :authenticate_user!


    def index
        @user_diaries = Diary.where(user_id: current_user.id).order(diary_date: "ASC")
        @days = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]

        @search = params[:search]
        if @search.present?
        @user_diaries = @user_diaries.where("body LIKE ?", "%#{@search}%")
            .or(@user_diaries.where(diary_date: "%#{@search}%"))
            .or(@user_diaries.where("mental_comment LIKE ?", "%#{@search}%"))
            .or(@user_diaries.where("physical_comment LIKE ?", "%#{@search}%"))
        end
    end

    def new
        @diary = Diary.new
    end
    
    def create
        diary = Diary.new(diary_params)
        diary.user_id = current_user.id

        if diary.save
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
    end

    def show
        @diary = Diary.find(params[:id])
        @days = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]
    end

    def edit
        @diary = Diary.find(params[:id])
    end
    
    def update
        diary = Diary.find(params[:id])

        if diary.update(diary_params)
            redirect_to :action => "index"
        else
            redirect_to :action => "edit"
        end
    end

    def destroy
        diary = Diary.find(params[:id])
        diary.destroy
        redirect_to action: :index
    end

    def condition_index
        @user_diaries = Diary.where(user_id: current_user.id).order(diary_date: "ASC")
        @days = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]

        # グラフ用のデータを作る

        lasts = @user_diaries.last(8)
        mental_data = Array.new
        physical_data = Array.new

        lasts.each do |last|
            mental_array = Array.new
            physical_array = Array.new
            mental_array.push last.diary_date.strftime('%m/%d')
            physical_array.push last.diary_date.strftime('%m/%d')
        
            m = last.mental_condition
            if m == "良い"
                mental_array.push 2
            elsif m == "少し悪い"
                mental_array.push 1
            else
                mental_array.push 0
            end

            p = last.physical_condition
            if p == "良い"
                physical_array.push 2
            elsif p == "少し悪い"
                physical_array.push 1
            else
                physical_array.push 0
            end

            mental_data.push mental_array
            physical_data.push physical_array
            
        end

        @chart_data = [{name: "心の状態", data: mental_data}, {name: "体の状態", data: physical_data}]

    
        
    end


    private
    def diary_params
        params.require(:diary).permit(:body, :mental_condition, :mental_comment, :physical_condition, :physical_comment, :diary_date)
    end

end
