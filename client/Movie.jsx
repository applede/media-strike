// Task component - represents a single todo item
Movie = React.createClass({
  propTypes: {
    // This component gets the task to display through a React prop.
    // We can use propTypes to indicate it is required
    movie: React.PropTypes.object.isRequired
  },
  render() {
    return (
      <span>{this.props.movie.text}</span>
    );
  }
});
