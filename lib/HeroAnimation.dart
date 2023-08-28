import 'package:flutter/material.dart';

@immutable
class person {
  final String name;
  final int age;
  final String emoji;

  const person({required this.name, required this.age, required this.emoji});
}

const people = [
  person(name: "Divyanshu", age: 20, emoji: '👨‍💻'),
  person(name: "Divyanshi", age: 20, emoji: '👩‍🔬'),
  person(name: "Anurag", age: 20, emoji: '👶')
];

class HeroAnimation extends StatefulWidget {
  const HeroAnimation({super.key});

  @override
  State<HeroAnimation> createState() => _HeroAnimationState();
}

class _HeroAnimationState extends State<HeroAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade50,
        title: const Center(child: Text("Trio")),
      ),
      backgroundColor: Colors.grey.shade100,
      body: ListView.builder(
          itemCount: people.length,
          itemBuilder: (context, index) {
            final person = people[index];
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailsPage(Person: person)));
              },
              leading: Hero(
                  tag: person.name,
                  child: Text(
                    person.emoji,
                    style: const TextStyle(
                        fontSize: 40, decoration: TextDecoration.none),
                  )),
              title: Text(person.name),
              subtitle: Text("${person.age} years old"),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            );
          }),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final person Person;

  const DetailsPage({
    super.key,
    required this.Person,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade50,
        title: Hero(
          flightShuttleBuilder: (
              flightContext,
              animation,
              flightDirection,
              fromHeroContext,
              toHeroContext,
              ) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return Material(
                  color: Colors.transparent,
                  child: ScaleTransition(
                    scale: animation.drive(
                      Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).chain(
                        CurveTween(
                          curve: Curves.fastOutSlowIn,
                        ),
                      ),
                    ),
                    child: toHeroContext.widget,
                  ),
                );
              case HeroFlightDirection.pop:
                return Material(
                  color: Colors.transparent,
                  child: fromHeroContext.widget,
                );
            }
          },
          tag: Person.name,
          child: Center(
            child: Text(
              Person.emoji,
              style: const TextStyle(
                fontSize: 50,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              Person.name,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              '${Person.age} years old',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}