
import { Label } from "@/components/ui/label"
import { SelectValue, SelectTrigger, SelectItem, SelectContent, Select } from "@/components/ui/select"
import { Button } from "@/components/ui/button"
import { CardContent, Card } from "@/components/ui/card"

export function ProvidersList() {
  return (
    <div className="container mx-auto px-4 md:px-6 lg:px-8 py-8">
      <div className="grid grid-cols-1 md:grid-cols-[240px_1fr] gap-6">
        <div className="sticky top-0 pt-4 space-y-4">
          <h2 className="text-xl font-bold">Filters</h2>
          <div className="space-y-2">
            <div className="space-y-1">
              <Label htmlFor="service">Service</Label>
              <Select id="service">
                <SelectTrigger className="w-full">
                  <SelectValue placeholder="Select" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="1">Service 1</SelectItem>
                  <SelectItem value="2">Service 2</SelectItem>
                  <SelectItem value="3">Service 3</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-1">
              <Label htmlFor="location">Location</Label>
              <Select id="location">
                <SelectTrigger className="w-full">
                  <SelectValue placeholder="Select" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="1">Location 1</SelectItem>
                  <SelectItem value="2">Location 2</SelectItem>
                  <SelectItem value="3">Location 3</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>
        </div>
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          <Card>
            <CardContent className="flex flex-col items-center space-y-4 p-4">
              <img
                alt="Service Provider"
                className="w-24 h-24 rounded-full object-cover"
                height={100}
                src="/placeholder.svg"
                style={{
                  aspectRatio: "100/100",
                  objectFit: "cover",
                }}
                width={100}
              />
              <h3 className="text-lg font-bold">Provider Name</h3>
              <p className="text-sm text-gray-500">Service Type</p>
              <p className="text-sm text-gray-500">Location</p>
              <Button size="sm" variant="outline">
                View Details
              </Button>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="flex flex-col items-center space-y-4 p-4">
              <img
                alt="Service Provider"
                className="w-24 h-24 rounded-full object-cover"
                height={100}
                src="/placeholder.svg"
                style={{
                  aspectRatio: "100/100",
                  objectFit: "cover",
                }}
                width={100}
              />
              <h3 className="text-lg font-bold">Provider Name</h3>
              <p className="text-sm text-gray-500">Service Type</p>
              <p className="text-sm text-gray-500">Location</p>
              <Button size="sm" variant="outline">
                View Details
              </Button>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="flex flex-col items-center space-y-4 p-4">
              <img
                alt="Service Provider"
                className="w-24 h-24 rounded-full object-cover"
                height={100}
                src="/placeholder.svg"
                style={{
                  aspectRatio: "100/100",
                  objectFit: "cover",
                }}
                width={100}
              />
              <h3 className="text-lg font-bold">Provider Name</h3>
              <p className="text-sm text-gray-500">Service Type</p>
              <p className="text-sm text-gray-500">Location</p>
              <Button size="sm" variant="outline">
                View Details
              </Button>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  )
}
