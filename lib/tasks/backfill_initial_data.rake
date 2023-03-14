namespace :backfill_initial_data do
  desc "Backfills spreadsheets to the database." 
  task run: :environment do
    require 'csv'
    # locations
    CSV.foreach(Rails.root.join('lib', 'tasks', 'locations.csv'), headers: true) do |row|
      begin
        Location.create!(row)
      rescue ActiveRecord::RecordNotUnique
      end
    end
    # employees
    CSV.foreach(Rails.root.join('lib', 'tasks', 'employees.csv'), headers: true) do |row|
      begin
        emp = Employee.create!(row.to_h.except('location_id'))
      rescue ActiveRecord::RecordNotUnique
        emp = Employee.find_by_bic(row['bic'])
      end
      begin
        EmployeeLocation.create!(employee: emp, location_id: row['location_id'])
      rescue ActiveRecord::RecordNotUnique
      end
    end
    # ingredients
    CSV.foreach(Rails.root.join('lib', 'tasks', 'ingredients.csv'), headers: true) do |row|
      begin
        Ingredient.create!(row)
      rescue ActiveRecord::RecordNotUnique
      end
    end
    # recipes
    CSV.foreach(Rails.root.join('lib', 'tasks', 'recipes.csv'), headers: true) do |row|
      begin
        rec = Recipe.create!(row.to_h.except('quantity', 'ingredient_id'))
      rescue ActiveRecord::RecordNotUnique
        rec = Recipe.find(row['id'])
      end
      begin
        RecipeIngredient.create!(recipe: rec, ingredient_id: row['ingredient_id'], quantity: row['quantity']) if row['quantity'].to_i > 0
      rescue ActiveRecord::RecordNotUnique
      end
    end
    # menu
    CSV.foreach(Rails.root.join('lib', 'tasks', 'location_recipes.csv'), headers: true) do |row|
      begin
        LocationRecipe.create!(row)
      rescue ActiveRecord::RecordNotUnique
      end
    end
    # initialize inventory
    LocationRecipe.all.each do |loc_rec|
      puts loc_rec.location_id
      puts loc_rec.recipe_id
      loc_rec.recipe.ingredients.each do |ingredient|
        puts ingredient.name
        begin
          LocationIngredient.create!(location: loc_rec.location, ingredient: ingredient)
        rescue ActiveRecord::RecordNotUnique
        end
      end
    end
  end
end