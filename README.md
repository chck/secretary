# secretary

secretary is a chat bot built on the [Hubot][hubot] framework. It may change your monotonous daily life by awesome commands.

### Requirements

    node  5.1.0
    redis 3.0.5
    
### Install
    
    % npm install
    
### Run

    % HUBOT_SLACK_TOKEN=YOUR_SLACK_TOKEN ./bin/hubot -a slack 
    
### Debug Locally

You can test your hubot by running the following, however some plugins will not
behave as expected unless the [environment variables](#configuration) they rely
upon have been set.

You can start secretary locally by running:

    % bin/hubot

You'll see some start up output and a prompt:

    [Sat Feb 28 2015 12:38:27 GMT+0000 (GMT)] INFO Using default redis on localhost:6379
    secretary>

Then you can interact with secretary by typing `secretary help`.

    secretary> secretary help
    secretary animate me <query> - The same thing as `image me`, except adds [snip]
    secretary help - Displays all of the help commands that secretary knows about.
    ...

