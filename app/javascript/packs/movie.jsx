/**
*  Author: @huanlv94
*  Movie components for share movie page
*
*/

import React from 'react'
import ReactDOM from 'react-dom'
import { ToastContainer, toast } from 'react-toastify'
import 'react-toastify/dist/ReactToastify.css'
const axios = require('axios')
const REGEX_URL = /^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/

class Movie extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      youtube_id: '',
      loading: false,
      url: ''
    };
  }

  /*****
    Get youtube video metadata from API. Get `title` and `description` for `form` parameter
    @params:
      - videoId: Youtube video ID. Examp url: https://www.youtube.com/watch?v=kGT73GcwhCU, videoId is `kGT73GcwhCU`
     @return:
       - Video metadata
  */
  getVideoInfo(videoId) {
    const URL_API=`https://www.googleapis.com/youtube/v3/videos?id=${videoId}&key=AIzaSyAOsyFOE83LMqFM9rYrcWsrmKURUQ8Uikc&part=snippet`
    let data = {}
    return axios.get(URL_API).then((response) => {
      if (response.status < 299) {
        data = response.data.items[0].snippet
        return data
      } else {
        toast.error('Failure to fetch video metadata')
        return null
      }
    })
  }

  /*****
    Send XHR request to API create sharing
    @params:
      - form: movie paramters
      - token: auth token
     @return:
       - A promise response data from API
  */
  createNewSharing(form, token) {
    // TODO: move this request to libraries
    axios({
      method: 'post',
      url: '/movie/share',
      data: { authenticity_token: token, movie: form }
    }).then(response => {
      this.setState({
        loading: false,
        url: '',
        youtube_id: ''
      })
      const { data } = response
      toast.success(`Share video id '${form.youtube_id}' successfully!`)
    }).catch((err) => {
      const { message } = err.response.data
      message.map(mess => {
        toast.error(mess)
      })
      this.setState({
        loading: false
      })
    })
  }

  /*****
    Handler trigger when click button `Share`.
    Validate and push message when input is invalid
    @return:
      - A XHR call to API
  */
  onClickShare() {
    const { token } = this.props
    const { url } = this.state
    this.setState({
      loading: true
    })

    if (!url.match(REGEX_URL)) {
      toast.error("It's not a Youtube URL!")
      this.setState({
        loading: false
      })
    } else {
      let youtube_id = url.match(REGEX_URL)[1]
      let form = {
        youtube_id: youtube_id
      }

      this.getVideoInfo(youtube_id).then(data => {
        form.title = data.title
        form.description = data.description.slice(0, 100) + '...'

        return this.createNewSharing(form, token)
      })
      
    }
  }

  render() {
    const { loading } = this.state
    return (
      <div className='share-container'>
        <div className='share-content'>
          <h3>Share a movie:</h3>
          <div className="mb-3">
            <input
              type='text'
              className='form-control'
              id='youtube-url'
              placeholder="Youtube URL"
              onChange={(e) => this.setState({url: e.target.value})}
              name='youtube-url'
             />
          </div>
        </div>
        <div className='share-bottom'>
          {loading ?
            <div className="spinner-border text-primary" role="status"></div> :
            <button className='btn btn-primary full-width' onClick={() => this.onClickShare()}>Share</button>
          }
        </div>
        <ToastContainer />
      </div>
    );
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('sharing_data')
  const data = JSON.parse(node.getAttribute('data'))
  const authToken = document.getElementsByName('csrf-token')[0].content
  ReactDOM.render(
    <Movie data={data} token={authToken} />,
    document.getElementById('movie')
  )
})
