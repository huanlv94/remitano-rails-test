import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import _ from 'lodash'
const axios = require('axios')

class Home extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      loading: false,
      movies: this.props.data,
      user: this.props.user,
      token: this.props.token
    };
  }

  /**
    Infinity load when click button `Load more`
    * TODO:
  */
  loadMore() {
    this.setState({
      loading: true
    })
  }

  /*****
    Vote up or down a shared movie
    @params:
      - movieId: ID of shared movie
      - type: type of vote, current support `up` or `down`
     @return:
       - Response message and data movie when success, error when failure
  */
  vote(type, movieId) {
    const { token, movies } = this.state
    console.log(movieId)
    const form = {
      id: movieId,
      type
    }
    // TODO: move this request to libraries
    axios({
      method: 'post',
      url: '/movie/vote',
      data: { authenticity_token: token, movie: form }
    }).then((response) => {
      const { movie } = response.data

      let index = movies.findIndex(x => x.id == movie.id)
      movies[index] = movie
      this.setState({ movies: movies })
    }).catch((err) => {
    })
  }

  render() {
    const { loading, movies, user } = this.state

    return (
      <div className='share-container'>
        <div className='share-content'>
          {movies.map((movie) => (
            <div className='share-preview embed-responsive' key={movie.id}>
              <iframe width = '39%' className='embed-responsive-item' src={`https://www.youtube.com/embed/${movie.youtube_id}?rel=0`} allowFullScreen></iframe>
              <div className='share-description' width='60%'>
                <h6 className='share-description-title'>{movie.title}</h6>
                {movie.current_vote === null || movie.current_vote === '' ?
                  <div className='share-description-vote'>
                    {user &&
                      <div>
                        <h6 className='bi bi-hand-thumbs-down' onClick={() => this.vote('down', movie.id)}></h6>
                        <h6 className='bi bi-hand-thumbs-up' onClick={() => this.vote('up', movie.id)}></h6>
                      </div>
                    }
                  </div> :
                  <div className='share-description-vote'>
                    {user &&
                      <h6 className={`bi bi-hand-thumbs-${movie.current_vote}-fill`}></h6>
                    }
                  </div>
                }
                <p className='no-margin'>Share by: {movie.author_email}</p>
                <p className='no-margin'>
                  <span className="bi bi-hand-thumbs-up"></span>
                  <span>{movie.up_count}</span>
                  <span className="bi bi-hand-thumbs-down"></span>
                  <span>{movie.down_count}</span>
                 </p>
                <p className='no-margin'>Description:</p>
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
  const userNode = document.getElementById('user_info')
  let user = userNode ? userNode.getAttribute('data') : null
  const authToken = document.getElementsByName('csrf-token')[0].content
  ReactDOM.render(
    <Home data={data} token={authToken} user={user}/>,
    document.getElementById('home')
  )
})
