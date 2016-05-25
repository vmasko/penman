module FormHelper

  def schedule
    time = Time.now.change(min: 0).to_datetime.to_i
    list = [] << ['Publish right now', Time.now]
    (time..time + 1.week).step(1.hour) do |t|
      list << [Time.at(t).strftime('%H:%M %d %B %Y'), Time.at(t)]
    end
    list
  end

  def current_schedule(post)
    if @post.published_at > Time.now
      return ' (currently set to ' + @post.published_at.strftime('%H:%M %d %B %Y') + ')'
    end
    ''
  end
end
