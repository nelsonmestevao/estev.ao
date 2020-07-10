import Link from '../../../models/Link';

export default async (req, res) => {
  const {
    query: { slug },
    method,
  } = req;

  switch (method) {
    case 'GET':
      await Link.findOneAndUpdate(
        { slug },
        { $inc: { visits: 1 } },
        { new: true },
      )
        .then((link) => {
          if (link) {
            res.status(200).json(link);
          } else {
            res.status(404).json({ error: { message: 'No URL found' } });
          }
        })
        .catch((error) => {
          console.error(error);
          res.status(500).json({ error });
        });
      break;
    default:
      res.setHeader('Allow', ['GET']);
      res
        .status(405)
        .json({ error: { message: `Method ${method} Not Allowed` } });
  }
};
