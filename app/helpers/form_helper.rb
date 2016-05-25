module FormHelper

  def list_schedule
    time = Time.now.to_datetime.to_i
    list = []
    (time..time + 1.week).step(1.hour) do |t|
      list << [Time.at(t).strftime('%H:%M %d %B %Y'), Time.at(t)]
    end
    list
  end
end
