import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import _ from 'lodash'

class Home extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      loading: false,
      movies: this.props.data
    };
  }

  loadMore() {
    this.setState({
      loading: true
    })
  }

  render() {
    const { loading, movies } = this.state

    return (
      <div className='share-container'>
        <div className='share-content'>
          {movies.map((movie) => (
            <div className='share-preview embed-responsive' key={movie.id}>
              <iframe width = '39%' className="embed-responsive-item" src={`https://www.youtube.com/embed/${movie.youtube_id}?rel=0`} allowFullScreen></iframe>
              <div className='share-description' width='60%'>
                <h5>{movie.title}</h5>
                <p className='no-margin'>Share by: {movie.author_email}</p>
                <p className='no-margin'>
                  <span className="bi bi-hand-thumbs-up"></span>
                  <span>{movie.up_count}</span>
                  <span className="bi bi-hand-thumbs-down"></span>
                  <span>{movie.down_count}</span>
                 </p>
                <p className='no-margin'> Description:</p>
                <p style={{fontSize: '14px'}}>{movie.description}</p>
              </div>
            </div>
          ))}
          {movies.length >= 10 &&
            <div className='share-loadmore'>
              {loading ?
                <div className="spinner-border text-primary" role="status"></div> :
                <button className='btn btn-primary full-width' onClick={() => this.loadMore()}>Load more</button>
              }
            </div>
          }
        </div>
      </div>
    );
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('sharing_data')
  const data = JSON.parse(node.getAttribute('data'))
  const authToken = document.getElementsByName('csrf-token')[0].content
  ReactDOM.render(
    <Home data={data} token={authToken}/>,
    document.getElementById('home')
  )
})
