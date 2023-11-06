import React from 'react';
import Button from '@mui/material/Button';
import { useQuery, gql } from '@apollo/client';

function App() {
  const Get_articles = gql`
    {
      articles {
        title
        comments{body}
        commentsCount
      
      }
    }`;
  const { loading, error, data } = useQuery(Get_articles);
  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :{error.message} by server</p>;
  console.log(data.articles);
  return (
    <div>
        <Button variant="outlined">Hello world</Button>
        ${data.articles.map((article: any) => (article.title))}
        <br/>
    </div>
  );
}

export default App;
