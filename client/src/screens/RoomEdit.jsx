import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import "./RoomEdit.css";
import { Button } from "react-bootstrap";

export default function RoomEdit(props) {
  const [formData, setFormData] = useState({
    name: "",
  });
  const { id } = useParams();

  useEffect(() => {
    const prefillFormData = () => {
      const singleRoom = props.rooms.find((room) => room.id === Number(id));
      setFormData({
        name: singleRoom.name,
      });
    };
    if (props.rooms.length) {
      prefillFormData();
    }
  }, [props.rooms, id]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevState) => ({
      ...prevState,
      [name]: value,
    }));
  };

  return (
    <div className='room-edit'>
    <form
      className='form-edit'
      onSubmit={(e) => {
        e.preventDefault();
        props.handleRoomUpdate(id, formData);
      }}
    >
      <h3>Change Room</h3>
      <label>
        Name:
        <input
          type="text"
          name="name"
          value={formData.name}
          onChange={handleChange}
        />
      </label>
      <br />
      <Button>Submit</Button>
    </form>
    </div>
  );
}
