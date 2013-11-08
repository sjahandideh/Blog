module Demo
  TICK = "&#x2713;"

  attr_accessor :last_step

  def demo_step description, args={}
    if demo?
      page.execute_script %{
        $("body").prepend("<div id='step' style='font-size: 2em' class='alert alert-info'>#{description}<button style='margin-left:15px' onclick='$(this).parent().hide()'>Go</button></div>");
      }
      page.execute_script %{
        $("body").prepend("<div id='last-step' style='font-size: 2em' class='alert'>#{last_step} #{TICK}</div>");
      } if last_step.present?
      @last_step = description unless args[:title]
      using_wait_time(1000) do
        page.should have_no_css '#step', :visible => true
      end
    end

    if demo_step?
      puts "Step: #{description}".cyan
    end
  end

  def demo_step?
    example.metadata[:step]
  end

  def demo?
    example.metadata[:demo]
  end

  def set_speed(speed)
    begin
      page.driver.browser.send(:bridge).speed=speed
    rescue
    end
  end
end

RSpec.configuration.include Demo

RSpec.configure do |config|
  config.before :each do
    if demo?
      Capybara.current_driver = :selenium
      set_speed(:slow)
      visit '/'
      demo_step(example.description, { :title => true })
    end
  end

  config.after :each do
    if demo?
      Capybara.use_default_driver
      set_speed(:medium)
    end
  end
end

module Selenium::WebDriver::Firefox
  class Bridge
    attr_accessor :speed

    def execute(*args)
      result = raw_execute(*args)['value']
      case speed
        when :slow
          sleep 0.3
        when :medium
          sleep 0.1
        when :fast
          sleep 0.05
      end
      result
    end
  end
end
