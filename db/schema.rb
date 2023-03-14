# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_14_081911) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employee_locations", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id", "location_id"], name: "index_employee_locations_on_employee_id_and_location_id", unique: true
    t.index ["employee_id"], name: "index_employee_locations_on_employee_id"
    t.index ["location_id"], name: "index_employee_locations_on_location_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name", null: false
    t.date "dob", null: false
    t.string "role"
    t.string "iban", null: false
    t.string "bic", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "dob"], name: "index_employees_on_name_and_dob", unique: true
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name", null: false
    t.string "unit", null: false
    t.decimal "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "location_ingredients", force: :cascade do |t|
    t.bigint "ingredient_id", null: false
    t.bigint "location_id", null: false
    t.decimal "inventory", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id", "location_id"], name: "index_location_ingredients_on_ingredient_id_and_location_id", unique: true
    t.index ["ingredient_id"], name: "index_location_ingredients_on_ingredient_id"
    t.index ["location_id"], name: "index_location_ingredients_on_location_id"
  end

  create_table "location_recipes", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "location_id", null: false
    t.decimal "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_location_recipes_on_location_id"
    t.index ["recipe_id", "location_id"], name: "index_location_recipes_on_recipe_id_and_location_id", unique: true
    t.index ["recipe_id"], name: "index_location_recipes_on_recipe_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_locations_on_name"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "ingredient_id", null: false
    t.decimal "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["recipe_id", "ingredient_id"], name: "index_recipe_ingredients_on_recipe_id_and_ingredient_id", unique: true
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
