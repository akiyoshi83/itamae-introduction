module RecipeHelper
  def include_cookbook(name)
    include_recipe File.join(__dir__, "cookbooks", name, "default.rb")
  end
end

Itamae::Recipe::EvalContext.include(RecipeHelper)

node[:roles].each do |role|
  include_recipe File.join("roles", "#{role}.rb")
end

