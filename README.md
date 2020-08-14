# Mod 3 Refactoring Workshop

## Background

Near Earth Objects is an educational command line tool that strives to interrupt the monotony of day to day living by allowing users to understand how close to extinction life on earth is at any given point in time. Every day thousands of NEOs (Near Earth Objects) i.e. comets, astroids, meteors pass by the earth at alarmingly close distances. One slight shift in the cosmos would cause these NEOs to crash into the earth, setting off a series of catastrophic events that would lead to the end of life as we know it (much like the fate of the dinosaurs). Now that we've discussed this, please take a moment to appreciate 3 small things in your life that you take for granted and assume will always be there...

## Instructions

Please follow these instructions for further enlightenment.

- Clone this repo
- Run `bundle install` to download and install all of the necessary dependencies
- This project uses NASA's Astroids - NeoWs API. Please signup for an API key [here](https://api.nasa.gov/)
- Once you have your api key, run `bundle exec figaro install`. This should create a file called `application.yml` located in the `config` folder. **Note:** This file is automatically gitignored and many IDEs do not show gitignored files by default. You may have to change your IDE's settings to show gitignored files.
- Append your api_key to `application.yml` in the following format `nasa_api_key: <Your API KEY Goes Here>`
- This project uses minitest. You can run the tests with the following command `ruby near_earth_objects_test.rb`
- To use the command line tool run `ruby start.rb`. You will be prompted to enter a date. Enter the date in the following format `YYYY-MM-DD` i.e. `2019-03-30`. Once you hit enter you will see information about the objects that came near to the earth on that day.

## Workshop

### Explore the code (15 min)

With your partner look through `start.rb` and `near_earth_objects.rb`

- Discuss is this 'good' or 'bad' code? Why?

Start file
 - Processing user data
 - Processing API data
 - No adherence to SRP.

  - "bad" code. Hard to understand. Would be hard to debug. Works, but is not built on convention.
  - refactoring focus on cleaning up file by moving code to appropriate classes to be processed and refactoring code into
  SRP methods. The start file will just have the responsibility of running a particular method that initiates the user prompt and data return cycle.

Near Earth Object.rb
 - There is only one method that handles all class responsibilities.
 - VERY hard to understand, test, and debug.

   - Objectively a "bad" class file. The fact that one method handles so much functionality is absurd.
   - refactoring focus on breaking up this file into many different helper methods with appropriate tests in order to adhere to SRP.

---

### Identify the responsibilities (10 min)

With your Partner, identify the different responsibilities that exist in each file.

- Does this adhere to SRP?
  - No, neither file adheres to SRP because each file is managing many different responsibilities in a very unconventional way. The theme being that all the code is lumped together to run this one very specific task, but therefore, none of it can be 1. reused 2. tested effectively 3. understood easily.

- How would you utilize encapsulation and abstraction to refactor this code?
  - Encapsulating the code is very important because each of the target files are great areas to refactor code into separate encapsulated methods with one single responsibility. This can be done by identifying the pieces of code that demonstrate a single responsibility and pulling those pieces out into their own methods. The code could also benefit from some abstraction to increase the efficiency of so many API data calls by consolidating them into perhaps one API data call that is then manipulated.

- What tools/strategies could you utilize to make this code adhere to SRP?
  - Some tools/strategies I can use are helper methods, more class files with specific responsibilites, potentially inheritance or modules etc. 

---

### Refactor (1 hour)

Declarative Programming:
- Write the code you wish existed above the existing code
- Keep the code that is currently working. Don't delete it until the new code is working. This way you will always have a passing solution

---

Red, Green, Refactor:
- Utilize tests to keep you moving in the right direction
- Follow the errors in the test to guide you each step of the way
