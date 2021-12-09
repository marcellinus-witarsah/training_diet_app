import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:training_and_diet_app/model/recipe.dart';
import 'package:training_and_diet_app/services/db.dart';
import 'package:training_and_diet_app/ui/bottom_nav_bar.dart';
import 'package:training_and_diet_app/ui/pages/recipes_detail.dart';
//import 'package:recipes_app/utils/store.dart';
//import 'package:recipes_app/ui/widgets/recipe_card.dart';
//import 'package:recipes_app/model/state.dart';
//import 'package:recipes_app/state_widget.dart';
//import 'package:recipes_app/ui/screens/login.dart';
//import 'package:recipes_app/ui/widgets/settings_button.dart';

int _selectedIndex = 2;
final _db = DatabaseService();

class RecipePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RecipePageState();
}

class RecipePageState extends State<RecipePage> {
  //StateModel appState;

  DefaultTabController _buildTabView({Widget body}) {
    const double _iconSize = 20.0;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          child: BottomNavBar(2),
        ),
        appBar: PreferredSize(
          // We set Size equal to passed height (50.0) and infinite width:
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            elevation: 2.0,
            backgroundColor: Color(0xFF200087),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: body,
        ),
      ),
    );
  }

  Widget _buildContent() {
    /*if (appState.isLoading) {
      return _buildTabView(
        body: _buildLoadingIndicator(),
      );
    //} else if (!appState.isLoading && appState.user == null) {
      //return new LoginScreen();
    } else {*/
    return _buildTabView(
      body: _buildTabsContent(),
    );
    //}
  }

  Center _buildLoadingIndicator() {
    return Center(
      child: new CircularProgressIndicator(),
    );
  }

  /*Column _buildSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SettingsButton(
          Icons.exit_to_app,
          "Log out",
          /*appState.user.displayName,
          () async {
            await StateWidget.of(context).signOutOfGoogle();
          },*/
        ),
      ],
    );
  }*/

  TabBarView _buildTabsContent() {
    Padding _buildRecipes({List<String> ids}) {
      Stream<QuerySnapshot> stream;
      // The argument recipeType is set
      stream = _db.recipes.snapshots();
      // Use snapshots of all recipes if recipeType has not been passed

      // Define query depeneding on passed args
      return Padding(
        // Padding before and after the list view:
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: new StreamBuilder(
                stream: stream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return _buildLoadingIndicator();
                  return new ListView(
                    children: snapshot.data.docs
                        // Check if the argument ids contains document ID if ids has been passed:
                        .where((d) => ids == null || ids.contains(d.id))
                        .map((document) {
                      return new RecipeCard(
                        recipe: Recipe.fromMap(document.data(), document.id),
                        //inFavorites:
                        //  appState.favorites.contains(document.documentID),
                        //onFavoriteButtonPressed: _handleFavoritesListChanged,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return TabBarView(
      children: [
        _buildRecipes(),
        _buildRecipes(),
        // _buildRecipes(ids: appState.favorites),
        //_buildSettings(),
      ],
    );
  }

  /*void _handleFavoritesListChanged(String recipeID) {
    updateFavorites(appState.user.uid, recipeID).then((result) {
      if (result == true) {
        setState(() {
          if (!appState.favorites.contains(recipeID))
            appState.favorites.add(recipeID);
          else
            appState.favorites.remove(recipeID);
        });
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    // Build the content depending on the state:
    //appState = StateWidget.of(context).state;
    return _buildContent();
  }
}

/*class SettingsButton extends StatelessWidget {
  final IconData icon;
  final String title;
  //final String caption;
  //final Function onPressed;

  SettingsButton(this.icon, this.title/*, this.caption, this.onPressed*/);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      textColor: const Color(0xFF807a6b),
      padding: EdgeInsets.all(20.0),
      //onPressed: this.onPressed,
      child: Row(
        children: <Widget>[
          Icon(this.icon),
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(this.title),
              SizedBox(height: 5.0),
              //Text(this.caption, style: Theme.of(context).textTheme.caption),
            ],
          ),
        ],
      ),
    );
  }
}*/

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  //final bool inFavorites;
  //final Function onFavoriteButtonPressed;

  RecipeCard({
    @required this.recipe,
    /*@required this.inFavorites,
      @required this.onFavoriteButtonPressed*/
  });

  @override
  Widget build(BuildContext context) {
    /*RawMaterialButton _buildFavoriteButton() {
      return RawMaterialButton(
        constraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
        onPressed: () => onFavoriteButtonPressed(recipe.id),
        child: Icon(
          // Conditional expression:
          // show "favorite" icon or "favorite border" icon depending on widget.inFavorites:
          inFavorites == true ? Icons.favorite : Icons.favorite_border,
          color: Theme.of(context).iconTheme.color,
        ),
        elevation: 2.0,
        fillColor: Theme.of(context).buttonColor,
        shape: CircleBorder(),
      );
    }*/

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => new DetailScreen(recipe /*, inFavorites*/),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Card(
          color: Color(0xFF200087),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // We overlap the image and the button by
              // creating a Stack object:
              Stack(
                children: <Widget>[
                  RecipeImage(recipe.imageURL),
                  /*Positioned(
                    child: _buildFavoriteButton(),
                    top: 2.0,
                    right: 2.0,
                  ),*/
                ],
              ),
              RecipeTitle(recipe, 15),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeTitle extends StatelessWidget {
  final Recipe recipe;
  final double padding;

  RecipeTitle(this.recipe, this.padding);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        // Default value for crossAxisAlignment is CrossAxisAlignment.center.
        // We want to align title and description of recipes left:
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            recipe.name,
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          // Empty space:
          SizedBox(height: 10.0),
          Row(
            children: [
              Icon(
                Icons.timer,
                size: 20.0,
                color: Colors.white,
              ),
              SizedBox(width: 5.0),
              Text(
                recipe.getDurationString,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RecipeImage extends StatelessWidget {
  final String imageURL;

  RecipeImage(this.imageURL);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Image.network(
        imageURL,
        fit: BoxFit.cover,
      ),
    );
  }
}
