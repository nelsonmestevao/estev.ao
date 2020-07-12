import { nanoid } from 'nanoid';
import Link from '../../../models/Link';

export default async (req, res) => {
  const { body, method } = req;

  switch (method) {
    case 'POST':
      if (body?.url) {
        const slug = body.slug || nanoid(5);
        const url = !/^https?:\/\//i.test(body.url)
          ? `http://${body.url}`
          : body.url;

        if (
          !url.match(
            /(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_+.~#?&//=]*)/g,
          )
        ) {
          res.status(400).json({ error: { message: 'Invalid URL' } });
          break;
        }

        if (body.slug) {
          await Link.findOne({ slug }).then((link) => {
            if (link) {
              res
                .status(400)
                .json({ error: { message: 'Slug already taken' } });
            }
          });
        }

        await new Link({ slug, url })
          .save()
          .then((link) => {
            res.status(200).json(link);
          })
          .catch((error) => {
            console.error(error);
            res.status(500).json({ error });
          });
      } else {
        res.status(400).json({ error: { message: 'Missing URL field' } });
      }
      break;
    default:
      res.setHeader('Allow', ['POST']);
      res.status(405).json({
        error: { message: `Method ${method} Not Allowed` },
      });
  }
};
