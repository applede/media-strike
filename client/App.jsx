let { Input, ListGroup, ListGroupItem } = ReactBootstrap;

// App component - represents the whole app
App = React.createClass({

  // This mixin makes the getMeteorData method work
  mixins: [ReactMeteorData],

  // Loads items from the Tasks collection and puts them on this.data.tasks
  getMeteorData() {
    return {
      movies: Movies.find({}).fetch()
    }
  },

  renderMovies() {
    return this.data.movies.map((movie) => {
      return (
        <ListGroupItem key={movie._id}>
          <Movie movie={movie} />
        </ListGroupItem>
      )
    });
  },

  handleSubmit(event) {
    event.preventDefault();

    // Find the text field via the React ref
    var text = React.findDOMNode(this.refs.textInput).value.trim();

    Movies.insert({
      text: text,
      createdAt: new Date() // current time
    });

    // Clear form
    React.findDOMNode(this.refs.textInput).value = "";
  },

  render() {
    return (
      <div className="container">
        <header>
          <h1>Movie List</h1>

          <form onSubmit={this.handleSubmit} >
            <input className='form-control'
              type="text"
              ref='textInput'
              placeholder="Type to add new movies" />
          </form>
        </header>
        <p></p>

        <ListGroup>
          {this.renderMovies()}
        </ListGroup>
      </div>
    );
  }
});
