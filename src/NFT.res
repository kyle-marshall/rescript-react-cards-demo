type attribute = {
  name: string,
  value: string,
  tier: string,
  percentage: float,
}

type collectionItem = {
  name: string,
  attributes: array<attribute>,
  description: string,
  imageURI: string,
}