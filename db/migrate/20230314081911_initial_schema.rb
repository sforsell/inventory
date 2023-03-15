class InitialSchema < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.string :parameterized_name, index: true
      t.string :address
      t.timestamps
    end

    create_table :employees do |t|
      t.string :name, null: false
      t.date :dob, null: false
      t.string :role
      t.string :iban, null: false
      t.string :bic, null: false
      t.timestamps
      t.index %i[name dob], unique: true
    end

    create_table :employee_locations do |t|
      t.references :employee, index: true, null: false
      t.references :location, index: true, null: false
      t.timestamps
      t.index %i[employee_id location_id], unique: true
    end

    create_table :recipes do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :ingredients do |t|
      t.string :name, null: false
      t.string :unit, null: false
      t.decimal :price, null: false
      t.timestamps
    end

    create_table :recipe_ingredients do |t|
      t.references :recipe, index: true, null: false
      t.references :ingredient, index: true, null: false
      t.decimal :quantity, null: false
      t.timestamps
      t.index %i[recipe_id ingredient_id], unique: true
    end

    create_table :location_recipes do |t|
      t.references :recipe, index: true, null: false
      t.references :location, index: true, null: false
      t.decimal :price, null: false
      t.timestamps
      t.index %i[recipe_id location_id], unique: true
    end

    create_table :location_ingredients do |t|
      t.references :ingredient, index: true, null: false
      t.references :location, index: true, null: false
      t.decimal :inventory, default: 0
      t.timestamps
      t.index %i[ingredient_id location_id], unique: true
    end

    # create_table :sales do |t|
    #   t.references :location, index: true, null: false
    #   t.references :location_recipe, index: true, null: false
    #   t.references :employee, null: false
    #   t.timestamps
    # end

    create_table :inventory_updates do |t|
      t.references :location, index: true, null: false
      t.references :location_ingredient, index: true, null: false
      # t.references :employee, null: false
      t.string :action, null: false #sales/delivery/loss
      t.decimal :old_value, null: false
      t.decimal :new_value, null: false
      t.timestamps
    end
  end
end
