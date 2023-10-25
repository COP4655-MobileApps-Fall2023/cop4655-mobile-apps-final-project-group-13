Original App Design Project - README Template
===

# RecipEasy

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview
This app will act as a digital cookbook for it’s users. 

### Description

In this app, users can view recipes from different categories of food and also be able to add their own recipes to the app. Users can also search for recipes by their title in a search bar. Each recipe will include: ingredients, preparation steps, cooking steps, and the possibilty of adding a picture of the cooked recipe. Users can also rate the recipe, giving both a rating for how it tasted and a rating for the cooking process (easy to hard). 

### App Evaluation

[Evaluation of your app across the following attributes]
- **Category:** Food & Drink.
- **Mobile:** It is designed for mobile devices, so it will be accessible on both smartphones and tablets.
- **Story:** The idea of this app is pretty simple to the audience. It will provide users with a digital cookbook, allowing them to access and create recipes. This app aims to simplify the recipe management process and enhance the cooking experience for users. The people including our peers would be more than happy to find a recipe for almost any food they want to cook right on their phone. 
- **Market:** The market we will be targeting are those who enjoy cooking and want to organize and/or create recipes. This app can be used by chefs on all skill levels.
- **Habit:** This app can become a habit for users that love to cook and want to find new recipes. Users will always be coming back to the app for numerous reasons; whether it is to scroll through a list of recipes, review one they tried, or even create their own.
- **Scope:** The app's scope includes basic functions like browsing, searching, adding, rating, and viewing recipes. The optional choice is to add a photo to a recipe is also a great function as it gives a visual representation of what the result can be.

## Product Spec

### 1. User Stories (Required and Optional)

* User can sign up
* User can log in
* User can go to a certain recipe category
* User can view the recipes
* User can add recipes (recipe name, photo, ingredients, preparation steps) and view them
* User can rate and unrate recipes
* User can sign out

**Optional Nice-to-have Stories**

* User can add comments on recipes
* User can reply to comments
* User can see trending recipes
* User can view their profile
* User can add a recipe to favorites

### 2. Screen Archetypes

- [ ] Login/Register
* User can log in 
- [ ] Signup Screen
* User can create a new account
- [ ] Main Screen
* User can search for a recipe 
* User can click on a recipe category
* User can go to personal recipes
- [ ] Stream 
* User can view recipes for that category 
* User can click on a recipe 
* User can rate a recipe
- [ ] Details 
* User can view recipe name, photo, ingredients, and preparation steps
* User can rate a recipe
- [ ] Creation
* User can add their own recipe which includes recipe name, photo, ingredients, and preparation steps
- [ ] Search
* User can search for a specific recipe they are looking for
- [ ] Profile 
* User can view their name and recipes created by them


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Main feed
* Search recipe
* Profile / Personal recipes 

**Flow Navigation** (Screen to Screen)

* Login Screen
=> Main 
* Signup Screen
=> Main
* Main Screen
=> Stream
* Stream
=> Details Screen
* Details Screen
=> None (Just views the recipe details such as recipe name, photo, ingredients, and preparation steps)
* Search Screen
=> Stream Screen (filtered)
* Profile Screen
=> Creation Screen
* Creation Screen
=> Profile Screen (Takes us back to the profile screen that lists the recipes the user just created)


## Wireframes
![](https://hackmd.io/_uploads/rJrPMz8Mp.png)


### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

[This section will be completed in Unit 9]

### Models

[Add table of models]

### Networking

- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]

