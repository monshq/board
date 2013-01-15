# https://gist.github.com/907555

module ApplicationHelper
  def inside_layout(layout = 'application', &block)
    render :inline => capture_haml(&block), :layout => "layouts/#{layout}"
  end
end
