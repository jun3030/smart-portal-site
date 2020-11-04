class StoreManager::TopPageController < StoreManager::Base
  include SmartYoyakuApi::Calendar
  before_action :set_store_manager_and_store

  def top
    if @store_manager.order_plan.nil?
      flash.now[:notice] = "現在ご利用中のプランは【無料プラン】となっており、#{@store.store_name}様のページは非公開となっております。<br>
                            「登録内容の編集」から有料プランをご契約いただきますとページが公開され、お客様からのご予約が可能となります。".html_safe
    end
    @messages = Message.where(checked: "未読", store_id: @store.id).count
    @overtime_notice = Attendance.where(overtime_status: "申請中", confirmation: @user.name).count
  end

  def update_calendar_status
    set_status
    # 予約カレンダーの表示を切り替える
    @response = update_holiday_flag(@store, @status)
    @store.update!(calendar_status: JSON.parse(@response)["calendar_status"])
    flash.now[:notice] = "#{flash_message}"
    render :top
  end

  private

    def set_store_manager_and_store
      @store_manager = current_store_manager
      @store = @store_manager.store
    end

    # 現在公開中の場合「private(非公開)」、非公開中の場合「released(公開中)」をset
    def set_status
      @status =
        @store.calendar_status == "released" ? "private" : "released"
    end

    # 更新後のcalendar_statusに合わせてメッセージを変更
    def flash_message
      @store.calendar_status == "released" ? "カレンダーを公開しました。" : "カレンダーを非公開にしました。"
    end
end
