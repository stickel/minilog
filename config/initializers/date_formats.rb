# List of all the date formats
date_formats = {
  # :base               =>  "%B %e, %Y",
  :full               =>  "%B %e, %Y %I:%M%p",
  :long_form          =>  "%A, %B %e, %Y",
  :long_with_time     =>  "%A, %B %e, %Y at %I:%M%p",
  :short_form         =>  "%a, %b %e, %y",
  :short_with_time    =>  "%a, %b %e, %y at %I:%M%p",
  :digits             =>  "%d/%m/%Y",
  :digits_reverse     =>  "%Y/%m/%d",
  :time               =>  "%I:%M%p",
  :month              =>  "%B",
  :month_digit        =>  "%m"
}

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(date_formats)
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(date_formats)