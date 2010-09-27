require "pathname"
begin
  require "bacon"
rescue LoadError
  require "rubygems"
  require "bacon"
end

begin
  if (local_path = Pathname.new(__FILE__).dirname.join("..", "lib", "won.rb")).file?
    require local_path
  else
    require "won"
  end
rescue LoadError
  require "rubygems"
  require "won"
end

Bacon.summary_on_exit

describe "Spec Helper" do
  it "Should bring our library namespace in" do
    Won.should == Won
  end
end


