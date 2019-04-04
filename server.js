const stripeSecretKey = process.env.STRIPE_SECRET_KEY

const express = require('express')
const app = express()

app.set('veiw engine', 'ejs')
app.use(express.static('public'))
app.listen(3000)