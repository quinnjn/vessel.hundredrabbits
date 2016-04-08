class Event

  def initialize(row)
    @date = row[0]
    @type = row[1]
    @title = row[2]
    @details = row[3]
    @url = row[4]
    @isPaid = row[5].to_i
    @icon_align = 10.5

    @extraClasses = ""
  end

  def date
    return @date
  end

  def type
    return @type
  end

  def title
    return url ? "<a href='#{@url}' target='_blank' class='#{((isPaid) ? "paid" : "")}'>#{@title}</a>" : "#{@title}"
  end

  def details
    return @details
  end

  def url
    if "#{@url}".strip == "" then return end
    return @url
  end

  def isPaid
    if @isPaid > 0 then return true end
    return
  end

  def year
    return @date.split("-")[0].to_i
  end

  def month
    return @date.split("-")[1].to_i
  end

  def day
    return @date.split("-")[2].to_i
  end

  def time
    return Date.new(year,month,day).to_time.to_i
  end

  def elapsed
    return Time.new.to_i - time
  end

  def offset
    if year < 1 then return "" end

    timeDiff = (elapsed/86400)

    if timeDiff < -1 then return "In "+(timeDiff*-1).to_s+" days" end
    if timeDiff == -1 then return "tomorrow" end
    if timeDiff == 0 then return "today" end
    if timeDiff == 1 then return "yesterday" end
    if timeDiff == 7 then return "a week ago" end
    if timeDiff > 740 then return (timeDiff/30/12).to_s+" years ago" end
    if timeDiff > 60 then return (timeDiff/30).to_s+" months ago" end
    if timeDiff > 30 then return "a month ago" end

    return timeDiff.to_s+" days ago"
  end

  def offset_months
    return (elapsed/86400)/30
  end

  def imageExists date
    imageName = "#{date}".gsub("-","").to_i
    if imageName < 1 then return end
    if File.exist?("img/#{imageName}.jpg") then return true end
    return
  end

  def addClass className
    @extraClasses += "#{className} "
  end

  def template
    if type == "milestone" then return template_milestone end
    if type == "event" then return template_event end
    if type == "diary" then return template_diary end
    if type == "release" then return template_release end
    if type == "expense" then return template_expense end
    if type == "sail" then return template_sail end
    if type == "video" then return template_video end
    if type == "patreon" then return template_patreon end
    if type == "first" then return template_first end
    return template_missing
  end

  def template_missing
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <text>
        <span class='title'>#{title}</span>
        <span class='details'>#{details}</span>
        <span class='offset'>#{offset}</span>
      </text>
      <svg class='icon'><circle cx='10.5' cy='10.5' r='3' fill='#fff'></circle></svg>
      <line class='spacer'></line>
    </event>"
  end

  def template_release
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <text>
        <span class='title'>#{title}</span>
        <span class='details'>#{details}</span>
        <span class='offset'>#{offset}</span>
      </text>
      <svg class='icon'><circle cx='10.5' cy='10.5' r='3' fill='#fff'></circle><circle cx='10.5' cy='10.5' r='5' fill='none' stroke='white' stroke-width='1px'></circle></svg>
      <line class='spacer'></line>
    </event>"
  end

  def template_event
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <text>
        <span class='title'>#{title}</span>
        <span class='offset'>#{offset}</span>
      </text>
      <svg class='icon'><line x1='#{@icon_align}' y1='#{@icon_align + 4}' x2='#{@icon_align + 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align - 4}' x2='#{@icon_align + 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align + 4}' x2='#{@icon_align - 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align - 4}' x2='#{@icon_align - 4}' y2='#{@icon_align}'/></svg>
      <line class='spacer'></line>
    </event>"
  end

  def template_diary
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <text>
        <span class='title'>#{title}</span>
        <span class='offset'>#{offset}</span>
      </text>
      <svg class='icon'><circle cx='#{@icon_align}' cy='#{@icon_align}' r='3'></circle></svg>
      <line class='spacer'></line>
    </event>"
  end

  def template_expense
    return "
    <event time='#{time}' class='#{type} #{@extraClasses} #{(details.to_i > 0 ? "gain" : "spending")}'>
      <text>
        <span class='title'>#{title}</span>
        <span class='details'>#{details}$</span>
      </text>
      <svg class='icon'><circle cx='#{@icon_align}' cy='#{@icon_align}' r='3'></circle></svg>
      <line class='spacer'></line>
    </event>"
  end

  def template_sail
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <text>
        <span class='title'>Sail to #{title}</span>
        <span class='details'>+#{details}nm</span>
      </text>
      <svg class='icon'><polygon points='10.5,2 5.5,11 15.5,11' style='fill:#333' /></svg>
      <line class='spacer'></line>
    </event>"
  end

  def template_video
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <text>
        <span class='title'><a href='#{url}' target='_blank'>#{title}</a></span>
        <span class='details'>#{details}</span>
        <span class='offset'>#{offset}</span>
      </text>
      <svg class='icon'><line x1='#{@icon_align}' y1='#{@icon_align + 4}' x2='#{@icon_align + 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align - 4}' x2='#{@icon_align + 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align + 4}' x2='#{@icon_align - 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align - 4}' x2='#{@icon_align - 4}' y2='#{@icon_align}'/></svg>
      <line class='spacer'></line>
    </event>"
  end

  def template_patreon
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <text>
        <span class='title'>#{title} Patreons</span>
        <span class='details'>+#{details}$</span>
      </text>
    </event>"
  end

  def template_first
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <text>
        <span class='title'>#{title}</span>
        <span class='details'>#{details}</span>
      </text>
    </event>"
  end

end