import React from 'react'
import ReactDOM from 'react-dom'
import { ToastContainer, toast } from 'react-toastify'
import 'react-toastify/dist/ReactToastify.css'
const axios = require('axios')

class Movie extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      url: '',
      loading: false,
    };
  }

  onClickShare () {
    const { user_id } = this.props.data
    const { token } = this.props
    const { url } = this.state
    this.setState({
      loading: true
    })
    if (url.length < 20 || !url.includes('youtube.com/')) {
      toast.error("It's not a Youtube URL!")
    } else {
      let form = {
        url,
        authenticity_token: token,
        user_id
      }
      console.log(form)
      axios({
        method: 'post',
        url: '/movie/share',
        data: form
      }).then(function (response) {
        console.log(response)
      })
    }
    this.setState({
      loading: false
    })
  }

  render() {
    const { loading } = this.state
    return (
      <div className='share-container'>
        <div className='share-content'>
          <h3>Share a movie:</h3>
          <div className="mb-3">
            <input
              type="email"
              className="form-control"
              placeholder="Youtube URL"
              onChange={(e) => this.setState({url: e.target.value})}
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
