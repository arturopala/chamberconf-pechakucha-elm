Functional Reactive Frontend in Elm
===================================

# slide 1

Elm is ...
functional
reactive
frontend
lang and arch

# slide 2

Elm promises code
shockingly fast
nicely modular 
easy to test
refactor and debug

# slide 3

Elm is functional
same input -> same output
transform data not mutate
function is a value
apply it or pass it

# slide 4

Elm is reactive
data keep flowing
you merge/fork them
you transform them
you emit new data 

# slide 5

Elm language has
strong typing
stateless functions
pattern matching
modular design

# slide 6

Elm lang got not
variables
statements
null values
exceptions

# slide 7

With Elm come tools
elm-to-js transpiler
good core library
blazing fast html
package manager

# slide 8

Elm architecture is
a simple pattern for 
nestable components
great for modularity
code reuse and testing

# slide 9

Logic of Elm app/comp
breaks up into three
cleanly separated parts
model, update and view
this is the essence

# slide 10

How it works?
elm monitors the messages 
and feeds them into the update
so the model gets updated 
then elm-html renders a view

# slide 11

main: Signal Html
Elm figures out how to
render our Html efficiently

# slide

Meet new guys ...
Signal a
Addres a
Mailbox a
Task x a

#slide

type alias App model =
    { html : Signal Html
    , model : Signal model
    , tasks : Signal (Task.Task Never ())
    }


#slide

type alias Config model action =
    { init : (model, Effects action)
    , update : action -> model -> (model, Effects action)
    , view : Signal.Address action -> model -> Html
    , inputs : List (Signal.Signal action)
    }

# slide

type Effects a
    = Task (Task.Task Never a)
    | Tick (Time -> a)
    | None
    | Batch (List (Effects a))

# slide

type alias Html = VirtualDom.Node
type alias Attribute = VirtualDom.Property

# slide

Html.Lazy
bundle the function 
and arguments up for later
lazy : (a -> Html) -> a -> Html
lazy = VirtualDom.lazy

# slide

VirtualDom
API to the core diffing algorithm. 
Foundation for HTML or SVG.

# slide

Signals sets up a 
static processing network
inputs receive messages 
propagate through the network
to outputs that handle stuff

# slide

What about program state?
global state of application 
lives in the foldp function
we use signals to route there 
incoming and outgoing events

# slide

foldp is a ...
centralized data store 
that ensures consistency
(a -> s -> s) -> s -> Signal a -> Signal s
so simple?

# slide

Tasks are ...
asynchronous operations 
that may fail
like HTTP requests 
or writing to a database

# slide

Tasks in Elm ...
work like light-weight threads 
they can run at the same time
runtime will hop between them
can be chained and transformed


# slide

type alias Mailbox a =
    { address : Address a
    , signal : Signal a
    }

mailbox : a -> Mailbox a
send : Address a -> a -> Task x ()



# slide

StartApp package ...
lowers the barrier to entry
setting everything up 
so you can focus entirely 
on writing your app

# slide

model
type alias Model = ...
state of your app/component
init : (model, Effects action)

# slide

update
type Action = ...
describes what is possible
update : action -> model -> (model, Effects action)
actually perform those actions

# slide

type Effects a
represents some kind of effect
supports tasks for arbitrary effects 
and clock ticks for animations

# slide

start : Config model action -> App model

# slide

Ports are a ...
way to communicate with JS
let you send messages in/out 
so use JS whenever you need to
port user : Signal (String, UserRecord)

# slide

Elm app can be embedded 
directly in a <div> tag
easily integrated into page
or can run fullscreen
or have no graphics at all







