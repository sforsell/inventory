# rubocop:disable Metrics/BlockLength
namespace :backfill_initial_data do
  desc 'Backfills spreadsheets to the database. Ignores dupes'
  task run: :environment do
    require 'csv'
    # locations
    CSV.foreach(Rails.root.join('lib', 'tasks', 'locations.csv'), headers: true) do |row|
      Location.create!(row)
    rescue ActiveRecord::RecordNotUnique
      # let it slide
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
        # let it slide
      end
    end
    # ingredients
    CSV.foreach(Rails.root.join('lib', 'tasks', 'ingredients.csv'), headers: true) do |row|
      Ingredient.create!(row)
    rescue ActiveRecord::RecordNotUnique
      # let it slide
    end
    # recipes
    CSV.foreach(Rails.root.join('lib', 'tasks', 'recipes.csv'), headers: true) do |row|
      begin
        rec = Recipe.create!(row.to_h.except('quantity', 'ingredient_id'))
      rescue ActiveRecord::RecordNotUnique
        rec = Recipe.find(row['id'])
      end
      begin
        if row['quantity'].to_i.positive?
          RecipeIngredient.create!(recipe: rec, ingredient_id: row['ingredient_id'],
                                   quantity: row['quantity'])
        end
      rescue ActiveRecord::RecordNotUnique
        # let it slide
      end
    end
    # menu
    CSV.foreach(Rails.root.join('lib', 'tasks', 'location_recipes.csv'), headers: true) do |row|
      LocationRecipe.create!(row)
    rescue ActiveRecord::RecordNotUnique
      # let it slide
    end
    # initialize inventory
    LocationRecipe.all.each do |loc_rec|
      loc_rec.recipe.ingredients.each do |ingredient|
        LocationIngredient.create!(location: loc_rec.location, ingredient:)
      rescue ActiveRecord::RecordNotUnique
        # let it slide
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
